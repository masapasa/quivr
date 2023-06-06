from typing import List, Tuple

from pydantic import BaseModel

class ChatMessage(BaseModel):
    question: str
    history: List[List[str]]
    model: str
    temperature: float
    max_tokens: int
    use_summarization: bool = False
    file_name: str = ""

