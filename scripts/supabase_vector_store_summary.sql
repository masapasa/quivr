create table if not exists summaries (
    id bigserial primary key,
    document_id bigint references vectors(id),
    content text,
    metadata jsonb,
    embedding vector(1536)
);
CREATE OR REPLACE FUNCTION match_summaries(query_embedding vector(1536), match_count int, match_threshold float)
    RETURNS TABLE(
        id bigint,
        document_id bigint,
        content text,
        metadata jsonb,
        embedding vector(1536),
        similarity float)
    LANGUAGE plpgsql
    AS $$
    # variable_conflict use_column
BEGIN
    RETURN query
    SELECT
        id,
        document_id,
        content,
        metadata,
        embedding,
        1 -(summaries.embedding <=> query_embedding) AS similarity
    FROM
        summaries
    WHERE 1 - (summaries.embedding <=> query_embedding) > match_threshold
    ORDER BY
        summaries.embedding <=> query_embedding
    LIMIT match_count;
END;
$$;
