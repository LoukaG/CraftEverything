import { OpenAI } from 'openai';

const openai = new OpenAI({
    apiKey: process.env.OPENAI_API_KEY,
    project: process.env.OPENAI_PROJECT_ID,
});

export async function getCraftName(
    element1: string,
    element2: string
): Promise<string> {
    const prompt = `You are an expert in alchemy and crafting systems. Given two elements, your task is to return the name of the resulting element when they are combined.

        Instructions:

        Only return the name of the resulting element.

        Do not include emojis, explanations, or formatting.
        If the combination does not produce anything meaningful, respond with one of the combining element.

        Example:
        Element 1: "Water"
        Element 2: "Fire"
        Result: Steam

        Now respond with the result of combining:
        Element 1: "${element1}"
        Element 2: "${element2}"
                    `.trim();

    const chat = await openai.chat.completions.create({
        model: 'gpt-4-turbo',
        messages: [{ role: 'user', content: prompt }],
        temperature: 0.8,
    });

    const content = chat.choices[0]?.message?.content ?? '';
    const name = content.trim().replace(/^"|"$/g, '');

    return name;
}
