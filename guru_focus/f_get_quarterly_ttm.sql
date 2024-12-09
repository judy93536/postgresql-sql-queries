CREATE OR REPLACE FUNCTION get_quarterly_ttm(
    date_column TEXT,
    data_column TEXT,
    table_name TEXT,
    symbol_column TEXT,
    symbol_value TEXT,
    start_date TIMESTAMP DEFAULT NULL,
    end_date TIMESTAMP DEFAULT NULL
)
RETURNS TABLE (trade_date TIMESTAMP, ttm_value NUMERIC) AS $$
BEGIN
    RETURN QUERY EXECUTE format(
        'WITH filtered_data AS (
            SELECT %I AS trade_date, %I AS data_value
            FROM %I
            WHERE %I = %L
              AND (%I >= COALESCE(%L, %I))
              AND (%I <= COALESCE(%L, %I))
            ORDER BY %I
        ),
        ttm_data AS (
            SELECT
                trade_date,
                SUM(data_value) OVER (
                    ORDER BY trade_date
                    ROWS BETWEEN 3 PRECEDING AND CURRENT ROW
                ) AS ttm_value
            FROM filtered_data
        )
        SELECT *
        FROM ttm_data
        WHERE ttm_value IS NOT NULL
        ORDER BY trade_date;',
        date_column, data_column, table_name,
        symbol_column, symbol_value,
        date_column, start_date, date_column,
        date_column, end_date, date_column,
        date_column
    );
END;
$$ LANGUAGE plpgsql;