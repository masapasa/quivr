from typing import List, Tuple

from pydantic import BaseModel
class ChatMessage(BaseModel):
    model: str = "gpt-3.5-turbo"
    question: str
    history: List[Tuple[str, str]]
    temperature: float = 0.0
    max_tokens: int = 256
    use_summarization: bool = False
