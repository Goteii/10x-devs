-- Migration: Initial Schema Creation
-- Description: Creates the core tables for the 10xCards application including flashcards, generations,
-- and generation error logs with proper relationships and security policies.
-- Tables: flashcards, generations, generation_error_logs
-- Author: AI Assistant
-- Date: 2024-03-20

-- Enable required extensions
create extension if not exists "uuid-ossp";

-- Create tables
create table if not exists public.generations (
    id bigserial primary key,
    user_id uuid not null references auth.users(id) on delete cascade,
    model varchar not null,
    generated_count integer not null,
    accepted_unedited_count integer,
    accepted_edited_count integer,
    source_text_hash varchar not null,
    source_text_length integer not null check (source_text_length between 1000 and 10000),
    generation_duration integer not null,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create table if not exists public.flashcards (
    id bigserial primary key,
    front varchar(200) not null,
    back varchar(500) not null,
    source varchar not null check (source in ('ai-full', 'ai-edited', 'manual')),
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    generation_id bigint references public.generations(id) on delete set null,
    user_id uuid not null references auth.users(id) on delete cascade
);

create table if not exists public.generation_error_logs (
    id bigserial primary key,
    user_id uuid not null references auth.users(id) on delete cascade,
    model varchar not null,
    source_text_hash varchar not null,
    source_text_length integer not null check (source_text_length between 1000 and 10000),
    error_code varchar(100) not null,
    error_message text not null,
    created_at timestamptz not null default now()
);

-- Create indexes for better query performance
create index if not exists flashcards_user_id_idx on public.flashcards(user_id);
create index if not exists flashcards_generation_id_idx on public.flashcards(generation_id);
create index if not exists generations_user_id_idx on public.generations(user_id);
create index if not exists generation_error_logs_user_id_idx on public.generation_error_logs(user_id);

-- Create trigger for updating updated_at timestamp
create or replace function public.handle_updated_at()
returns trigger as $$
begin
    new.updated_at = now();
    return new;
end;
$$ language plpgsql;

create trigger set_updated_at
    before update on public.flashcards
    for each row
    execute function public.handle_updated_at();

create trigger set_updated_at
    before update on public.generations
    for each row
    execute function public.handle_updated_at();

-- Enable Row Level Security
alter table public.flashcards enable row level security;
alter table public.generations enable row level security;
alter table public.generation_error_logs enable row level security;

-- RLS Policies for flashcards

-- Allow authenticated users to view their own flashcards
create policy "Users can view their own flashcards"
    on public.flashcards
    for select
    to authenticated
    using (auth.uid() = user_id);

-- Allow authenticated users to insert their own flashcards
create policy "Users can insert their own flashcards"
    on public.flashcards
    for insert
    to authenticated
    with check (auth.uid() = user_id);

-- Allow authenticated users to update their own flashcards
create policy "Users can update their own flashcards"
    on public.flashcards
    for update
    to authenticated
    using (auth.uid() = user_id)
    with check (auth.uid() = user_id);

-- Allow authenticated users to delete their own flashcards
create policy "Users can delete their own flashcards"
    on public.flashcards
    for delete
    to authenticated
    using (auth.uid() = user_id);

-- RLS Policies for generations

-- Allow authenticated users to view their own generations
create policy "Users can view their own generations"
    on public.generations
    for select
    to authenticated
    using (auth.uid() = user_id);

-- Allow authenticated users to insert their own generations
create policy "Users can insert their own generations"
    on public.generations
    for insert
    to authenticated
    with check (auth.uid() = user_id);

-- Allow authenticated users to update their own generations
create policy "Users can update their own generations"
    on public.generations
    for update
    to authenticated
    using (auth.uid() = user_id)
    with check (auth.uid() = user_id);

-- Allow authenticated users to delete their own generations
create policy "Users can delete their own generations"
    on public.generations
    for delete
    to authenticated
    using (auth.uid() = user_id);

-- RLS Policies for generation_error_logs

-- Allow authenticated users to view their own error logs
create policy "Users can view their own error logs"
    on public.generation_error_logs
    for select
    to authenticated
    using (auth.uid() = user_id);

-- Allow authenticated users to insert their own error logs
create policy "Users can insert their own error logs"
    on public.generation_error_logs
    for insert
    to authenticated
    with check (auth.uid() = user_id);

-- Note: No update/delete policies for error logs as they should be immutable 