(function () {
    const grid = document.getElementById("piecesGrid");
    if (!grid) return;

    const buttons = Array.from(document.querySelectorAll(".filter-btn"));
    const cards = Array.from(grid.querySelectorAll(".card"));

    function setActive(btn) {
        buttons.forEach((b) => b.classList.toggle("is-active", b === btn));
    }

    function applyFilter(filter) {
        const f = (filter || "all").toLowerCase();

        cards.forEach((card) => {
            const cats = (card.getAttribute("data-categories") || "")
                .split("|")
                .filter(Boolean);
            const show = f === "all" ? true : cats.includes(f);
            card.style.display = show ? "" : "none";
        });
    }

    buttons.forEach((btn) => {
        btn.addEventListener("click", () => {
            const filter = btn.getAttribute("data-filter") || "all";
            setActive(btn);
            applyFilter(filter);
        });
    });

    applyFilter("all");
})();