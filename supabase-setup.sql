-- Supabase SQL Editor: einmal ausführen, bei Bedarf erneut ausführbar.
create table if not exists public.fitness_data (
  user_id uuid primary key references auth.users (id) on delete cascade,
  payload jsonb not null,
  version bigint not null default 1,
  updated_at timestamptz not null default now()
);

alter table public.fitness_data enable row level security;
revoke all on table public.fitness_data from anon, authenticated;
grant select, insert, update on table public.fitness_data to authenticated;

drop policy if exists "Users can read their own fitness data" on public.fitness_data;
drop policy if exists "Users can create their own fitness data" on public.fitness_data;
drop policy if exists "Users can update their own fitness data" on public.fitness_data;
create policy "Users can read their own fitness data"
  on public.fitness_data for select to authenticated
  using (auth.uid() = user_id);
create policy "Users can create their own fitness data"
  on public.fitness_data for insert to authenticated
  with check (auth.uid() = user_id);
create policy "Users can update their own fitness data"
  on public.fitness_data for update to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- Ein Profilname kann von genau einem Supabase-Konto beansprucht werden.
create table if not exists public.fitness_profiles (
  user_id uuid primary key references auth.users (id) on delete cascade,
  display_name text not null unique check (display_name in ('Carsten', 'Kathrin', 'Mathilda', 'Mariette')),
  created_at timestamptz not null default now()
);

alter table public.fitness_profiles enable row level security;
revoke all on table public.fitness_profiles from anon, authenticated;
grant select, insert on table public.fitness_profiles to authenticated;

drop policy if exists "Users can read their own fitness profile" on public.fitness_profiles;
drop policy if exists "Users can claim an available family profile" on public.fitness_profiles;
drop policy if exists "Users can claim the profile matching their email" on public.fitness_profiles;
create policy "Users can read their own fitness profile"
  on public.fitness_profiles for select to authenticated
  using (auth.uid() = user_id);
create policy "Users can claim the profile matching their email"
  on public.fitness_profiles for insert to authenticated
  with check (
    auth.uid() = user_id
    and (
      (display_name = 'Carsten' and lower(coalesce(auth.jwt() ->> 'email', '')) = 'grevingcarsten@gmail.com')
      or (display_name = 'Kathrin' and lower(coalesce(auth.jwt() ->> 'email', '')) = 'grevingkathrin@gmail.com')
      or (display_name = 'Mathilda' and lower(coalesce(auth.jwt() ->> 'email', '')) = 'mathildagreving@gmail.com')
      or (display_name = 'Mariette' and lower(coalesce(auth.jwt() ->> 'email', '')) = 'mariettegreving@gmail.com')
    )
  );
