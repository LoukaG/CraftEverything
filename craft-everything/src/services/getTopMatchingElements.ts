import { prisma } from '../db';

type ElementWithCraftSources = {
    name: string;
    sourceNames: string[];
};

export async function getTopMatchingElements(
    targetInputs: string[],
    max = 5
): Promise<string[]> {
    const crafts = await prisma.craft.findMany({
        include: {
            elementA: true,
            elementB: true,
            resultElement: true,
        },
    });

    const elementMap = new Map<string, ElementWithCraftSources>();

    for (const craft of crafts) {
        const resultName = craft.resultElement.name.toLowerCase();
        const sourceNames = [
            craft.elementA.name.toLowerCase(),
            craft.elementB.name.toLowerCase(),
        ];

        if (!elementMap.has(resultName)) {
            elementMap.set(resultName, {
                name: resultName,
                sourceNames: [],
            });
        }

        elementMap.get(resultName)!.sourceNames.push(...sourceNames);
    }

    // Calcul de similarité
    const scored = Array.from(elementMap.values())
        .map((e) => {
            const overlap = new Set(
                e.sourceNames.filter((s) =>
                    targetInputs.map((i) => i.toLowerCase()).includes(s)
                )
            ).size;
            return {
                name: e.name,
                score: overlap,
            };
        })
        .filter((e) => e.score > 0)
        .sort((a, b) => b.score - a.score)
        .slice(0, max);

    return scored.map((e) => e.name);
}
