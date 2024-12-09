-- Correct Function Definition for `get_quarterly_data`
CREATE OR REPLACE FUNCTION get_quarterly_data(
    date_column TEXT,
    data_column TEXT,
    table_name TEXT,
    symbol_column TEXT,
    symbol_value TEXT
)
RETURNS TABLE (trade_date TIMESTAMP, data_value NUMERIC) AS $$
BEGIN
    RETURN QUERY EXECUTE format(
        'SELECT %I AS trade_date, %I AS data_value
         FROM %I
         WHERE %I = %L
         ORDER BY %I;',
        date_column, data_column, table_name, symbol_column, symbol_value, date_column
    );
END;
$$ LANGUAGE plpgsql;