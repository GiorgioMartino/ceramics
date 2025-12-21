# Ceramics Portfolio

A Jekyll-based portfolio website designed to showcase ceramic works. This project uses a custom collection for "pieces" and includes a filterable gallery.

## Getting Started

### Prerequisites

*   **Ruby**: version 3.2.8 (managed via `asdf` recommended)
*   **Bundler**: `gem install bundler`

### Local Development

1.  **Install dependencies:**
    ```bash
    bundle install
    ```

2.  **Run the local server:**
    ```bash
    bundle exec jekyll serve
    ```
    The site will be available at `http://localhost:4000`.

## Adding New Pieces

Each ceramic work is stored as a Markdown file in the `_pieces` directory. To add a new piece:

1.  **Create a new Markdown file** in `_pieces/`, e.g., `_pieces/my-new-bowl.md`.
2.  **Add Front Matter** at the top of the file:
    ```yaml
    ---
    layout: piece
    title: "My New Bowl"
    date: 2023-10-27
    categories: [bowl, stoneware]
    image_path: /assets/pieces/my-new-bowl/main.jpg
    description: "A brief description of the piece."
    ---
    ```
3.  **Add content** below the front matter if you want a detailed write-up or more images.
4.  **Upload Assets**: Place images related to the piece in a corresponding subfolder under `assets/pieces/`.

## Gallery & Filtering

The gallery page (`pieces.md`) uses `assets/js/gallery.js` to provide client-side filtering.

*   **Categories**: The filters are generated based on the `categories` array in your piece's front matter.
*   **Grid**: The `gallery.html` layout handles the rendering of the cards that the script filters.

## Project Structure

*   `_pieces/`: Collection of individual ceramic works.
*   `_layouts/`: Templates for the default page, the gallery, and individual pieces.
*   `_includes/`: Reusable HTML components like `header.html` and `footer.html`.
*   `assets/`: Images, CSS, and JavaScript files.