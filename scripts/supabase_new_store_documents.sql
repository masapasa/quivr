create extension if not exists vector;
create table if not exists vectors (
id bigserial primary key,
user_id text,
content text,
metadata jsonb,
embedding vector(1536)
);
CREATE OR REPLACE FUNCTION match_vectors(query_embedding vector(1536), match_count int, p_user_id text, p_file_name text)
    RETURNS TABLE(
        id bigint,
        user_id text,
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
        user_id,
        content,
        metadata,
        embedding,
        1 -(vectors.embedding <=> query_embedding) AS similarity
    FROM
        vectors
    WHERE vectors.user_id = p_user_id AND vectors.metadata->>'file_name' = p_file_name
    ORDER BY
        vectors.embedding <=> query_embedding
    LIMIT match_count;
END;
$$;