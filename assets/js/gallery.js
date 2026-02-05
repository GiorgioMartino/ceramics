(function () {
    const grid = document.getElementById("piecesGrid");
    if (!grid) return;

    const tabButtons = Array.from(document.querySelectorAll(".tab-btn"));
    const filterSections = Array.from(document.querySelectorAll(".filters[data-status-filters]"));
    const cards = Array.from(grid.querySelectorAll(".card"));

    let currentStatus = "available";
    let currentFilter = "all";

    function setActiveTab(btn) {
        tabButtons.forEach((b) => b.classList.toggle("is-active", b === btn));
    }

    function showFiltersForStatus(status) {
        filterSections.forEach((section) => {
            const sectionStatus = section.getAttribute("data-status-filters");
            section.style.display = sectionStatus === status ? "" : "none";
        });
    }

    function getCurrentFilterButtons() {
        const activeSection = filterSections.find(
            (s) => s.getAttribute("data-status-filters") === currentStatus
        );
        return activeSection ? Array.from(activeSection.querySelectorAll(".filter-btn")) : [];
    }

    function setActiveFilter(btn) {
        const currentButtons = getCurrentFilterButtons();
        currentButtons.forEach((b) => b.classList.toggle("is-active", b === btn));
    }

    function applyFilters() {
        cards.forEach((card) => {
            const status = card.getAttribute("data-status") || "";
            const cats = (card.getAttribute("data-categories") || "")
                .split("|")
                .filter(Boolean);

            const statusMatch = status === currentStatus;
            const categoryMatch = currentFilter === "all" || cats.includes(currentFilter);

            card.style.display = statusMatch && categoryMatch ? "" : "none";
        });
    }

    function attachFilterListeners() {
        filterSections.forEach((section) => {
            const buttons = section.querySelectorAll(".filter-btn");
            buttons.forEach((btn) => {
                btn.addEventListener("click", () => {
                    currentFilter = btn.getAttribute("data-filter") || "all";
                    setActiveFilter(btn);
                    applyFilters();
                });
            });
        });
    }

    tabButtons.forEach((btn) => {
        btn.addEventListener("click", () => {
            currentStatus = btn.getAttribute("data-status") || "available";
            currentFilter = "all";
            setActiveTab(btn);
            showFiltersForStatus(currentStatus);
            applyFilters();
        });
    });

    attachFilterListeners();
    showFiltersForStatus(currentStatus);
    applyFilters();
})();