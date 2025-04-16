const OLLAMA_URL = 'http://localhost:11434/api/generate';

type LlamaResponse = {
    response: string;
};

async function callLlama(prompt: string): Promise<string> {
    const res = await fetch(OLLAMA_URL, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            model: 'llama3',
            prompt,
            stream: false,
        }),
    });

    const data = await res.json() as LlamaResponse;
    return data.response.trim();
}

export async function getEmojiForElement(name: string): Promise<string> {
    const prompt = `
  Suggest a single emoji that represents "${name}".
  Respond with the emoji only.
  `.trim();

    const response = await callLlama(prompt);
    const emoji = [...response][0];

    if (!emoji) {
        throw new Error(`No emoji returned for "${name}"`);
    }

    return emoji;
}


export async function isSynonymOfCandidates(name: string, candidates: string[]): Promise<string | false> {
    const prompt = `
            You are comparing a proposed element name to a list of existing elements.

            Proposed name: "${name}"

            Existing elements: ${candidates.join(", ")}

            Instructions:
            - Only return a match if the proposed name is nearly identical in meaning to one of the existing elements.
            - Accept only true synonyms or simple rewordings — names that would be understood the same way in most contexts.
            - Do NOT match based on shared origin, transformation, or similar categories.
            - Ash is NOT the same as Steam. Mud is NOT the same as Smoke.
            - Ignore etymology, ingredients, or what causes what — focus on meaning.

            Respond with:
            - One existing name (if nearly identical), or
            - The word: false

            Only return the result. No explanation.
            `.trim();



    const response = await callLlama(prompt);
    const cleaned = response.toLowerCase().replace(/[".]/g, '').trim();

    if (cleaned.includes('false')) return false;
    return cleaned;
}
