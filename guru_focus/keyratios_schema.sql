create table if not exists public.guru_keyratios
(
    symbol                     text      not null,
    date                       timestamp not null,
    eps_ttm                    numeric,
    eps_without_nri            numeric,
    eps_latest_quarter         numeric,
    eps_est_fy1                numeric,
    eps_est_fy2                numeric,
    revenue_ttm                numeric,
    revenue_per_share          numeric,
    revenue_est_fy1            numeric,
    revenue_est_fy2            numeric,
    pe_ratio                   numeric,
    pe_ratio_without_nri       numeric,
    forward_pe_ratio           numeric,
    shiller_pe_ratio           numeric,
    ps_ratio                   numeric,
    pb_ratio                   numeric,
    ev_to_ebitda               numeric,
    future_eps_growth_3_5y     numeric,
    future_revenue_growth_3_5y numeric,
    eps_growth_3y              numeric,
    revenue_growth_3y          numeric,
    rsi_14                     numeric,
    sma_50                     numeric,
    sma_200                    numeric,
    beta                       numeric,
    volatility_1y              numeric,
    created_at                 timestamp default CURRENT_TIMESTAMP,
    updated_at                 timestamp default CURRENT_TIMESTAMP,
    primary key (symbol, date)
);

alter table public.guru_keyratios
    owner to options;

create index if not exists idx_guru_keyratios_date
    on public.guru_keyratios (date);

