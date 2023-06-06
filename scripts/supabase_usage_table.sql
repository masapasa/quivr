create table
  stats (
    time timestamp,
    chat boolean,
    embedding boolean,
    details text,
    metadata jsonb,
    id integer primary key generated always as identity
  );