---
name: private-docs
description: >-
  Use when reading, searching, creating, or editing private Recyclarr notes in Outline
  (wiki.dailey.app) through the `outline` MCP server: maintainer notes, user feedback records,
  release or signing procedures, or anything that must stay out of public repositories. Triggers
  on "private docs", "Outline", "save this feedback", "check my notes".
---

# Private Docs (Outline)

## Collection boundary

MUST use only the Recyclarr collection. Every other collection, including the personal
collection, is off limits for reads and writes.

- Collection ID: `07af8191-9aa5-4b4e-baee-1aa63c9708b6`
  (<https://wiki.dailey.app/collection/recyclarr-a9GUWUQdff>)
- Every call that accepts `collectionId` MUST pass this ID, including `list_documents`, which
  otherwise searches all collections.
- Before reading, editing, moving, or deleting a document by ID or URL, `fetch` it and confirm
  its `collectionId` is this ID. Otherwise stop without acting.
- Nest documents only under parents inside this collection.
- Collection tools are denied in `.opencode/opencode.jsonc`. If a task needs another collection
  or a collection change, stop and ask the user.

## Tool behavior

Call tools through Code Mode as `tools.outline.<tool>`. Results are JSON text; `fetch` on a
document returns the JSON metadata, then the Markdown body.

- Search: `list_documents` is keyword full-text search, not semantic. Retry with synonyms before
  concluding nothing exists.
- Edit: use `update_document` with `editMode: "patch"`, `findText` copied verbatim from the
  fetched Markdown, and `text` as the replacement. Patch replaces only the first match, so make
  `findText` unique. `append` and `prepend` add content. Avoid `replace`; it resends the whole
  document and drops formatting Markdown cannot represent.
- Create: the title is a separate field; the body MUST NOT start with an H1.
- Delete: `delete_document` moves to trash, and `restore_document` recovers it.
- Fresh writes can lag search results; reuse IDs returned by create calls.
- After every write, `fetch` the document and verify title, body, and `collectionId`.
