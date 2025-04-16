import { prisma } from '../db';
import { getCraftName } from '../services/gptService';
import { getEmojiForElement } from '../services/llamaService';
import { getTopMatchingElements } from '../services/getTopMatchingElements';
import { isSynonymOfCandidates } from '../services/llamaService';

export async function handleCraftGeneration(element1Id: string, element2Id: string) {
    const e1 = await prisma.element.findUnique({ where: { id: element1Id } });
    const e2 = await prisma.element.findUnique({ where: { id: element2Id } });

    if (!e1 || !e2) return null;

    const candidates = await getTopMatchingElements([e1.name, e2.name]);

    const rawName = await getCraftName(e1.name, e2.name);
    if (!rawName) throw new Error('GPT returned no name');

    let finalName = rawName;
    console.log(rawName+"=>"+finalName);

    const [existingElement, emoji] = await Promise.all([
        prisma.element.findFirst({
            where: {
                name: {
                    equals: finalName,
                    mode: 'insensitive',
                },
            },
        }),
        getEmojiForElement(finalName),
    ]);

    let result = existingElement;

    if (!result) {
        result = await prisma.element.create({
            data: {
                name: finalName.trim(),
                icon: emoji,
            },
        });
    }
    const [id1, id2] = [e1.id, e2.id].sort();

    const craft = await prisma.craft.create({
        data: {
            element1: id1,
            element2: id2,
            resultId: result.id,
        },
        include: {
            resultElement: true,
        },
    });

    return craft.resultElement;
}
