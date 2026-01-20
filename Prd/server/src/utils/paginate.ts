export interface PaginatedResult<T> {
  items: T[];
  nextCursor: string | null;
}

const encodeCursor = (index: number) => Buffer.from(String(index)).toString('base64');
const decodeCursor = (cursor?: string) => {
  if (!cursor) return 0;
  const decoded = Buffer.from(cursor, 'base64').toString('utf8');
  const parsed = Number(decoded);
  return Number.isFinite(parsed) && parsed >= 0 ? parsed : 0;
};

export const paginate = <T>(
  collection: T[],
  cursor: string | undefined,
  limit: number,
): PaginatedResult<T> => {
  const start = decodeCursor(cursor);
  const slice = collection.slice(start, start + limit);
  const nextIndex = start + slice.length;
  const nextCursor = nextIndex < collection.length ? encodeCursor(nextIndex) : null;
  return { items: slice, nextCursor };
};
