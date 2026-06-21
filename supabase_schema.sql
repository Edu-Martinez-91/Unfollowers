-- ═══════════════════════════════════════════════════════════
-- ESQUEMA SUPABASE — IG Unfollowers
-- Ejecutar en: Supabase Dashboard → SQL Editor → New query
-- ═══════════════════════════════════════════════════════════

-- Una fila por usuario, con las tres listas de etiquetas en un único
-- jsonb (vip / unfollowed / unavailable). No hace falta migración de
-- esquema si la app añade más categorías en el futuro.
create table public.unfollowers_tags (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{"vip":[],"unfollowed":[],"unavailable":[]}'::jsonb,
  updated_at timestamptz default now()
);

-- ═══ SEGURIDAD: cada usuario solo ve/edita su propia fila ═══
alter table public.unfollowers_tags enable row level security;

create policy "unfollowers_tags_own" on public.unfollowers_tags
  for all using (user_id = auth.uid()) with check (user_id = auth.uid());

-- Trigger para updated_at
create or replace function public.touch_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger unfollowers_tags_touch before update on public.unfollowers_tags
  for each row execute function public.touch_updated_at();
