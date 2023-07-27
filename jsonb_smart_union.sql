create or replace function jsonb_array_unique(jsonb) returns jsonb
    IMMUTABLE
    PARALLEL safe
    RETURNS NULL ON NULL INPUT
language sql as
$func$
    with var as (SELECT jsonb_agg(DISTINCT x) as c FROM jsonb_array_elements($1) t(x) WHERE x != 'null')
        select case
            when jsonb_array_length(var.c) > 1 then var.c
            when jsonb_array_length(var.c) = 1 then var.c -> 0
        end from var
$func$;

create or replace function jsonb_union(jsonb, jsonb) returns jsonb
    language sql
    immutable
    PARALLEL safe
as $func$
    select
        case
            when jsonb_typeof($1) = 'object' and jsonb_typeof($2) = 'object' then
                (SELECT
                    jsonb_object_agg(
                        key,
                        jsonb_union(
                            coalesce($1 -> key, '[]'::jsonb),
                            coalesce($2 -> key, '[]'::jsonb)
                        )
                    ) FROM jsonb_object_keys($1 || $2) t(key))
            else jsonb_array_unique($1 || $2)
        end;
$func$;

CREATE OR REPLACE AGGREGATE jsonb_union_agg(jsonb)
(
    SFUNC = jsonb_union,
    STYPE = jsonb,
    PARALLEL = SAFE,
    INITCOND = '{}'
);