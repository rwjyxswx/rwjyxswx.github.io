document.addEventListener('DOMContentLoaded', function() {
  const searchToggle = document.getElementById('search-toggle');
  const searchModal = document.getElementById('search-modal');
  const searchInput = document.getElementById('search-input');
  const searchClose = document.getElementById('search-close');
  const searchResults = document.getElementById('search-results');

  searchToggle.addEventListener('click', function() {
    searchModal.classList.toggle('active');
    if (searchModal.classList.contains('active')) {
      searchInput.focus();
    }
  });

  searchClose.addEventListener('click', function() {
    searchModal.classList.remove('active');
    searchInput.value = '';
    searchResults.innerHTML = '';
  });

  document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') {
      searchModal.classList.remove('active');
      searchInput.value = '';
      searchResults.innerHTML = '';
    }
    if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
      e.preventDefault();
      searchModal.classList.toggle('active');
      if (searchModal.classList.contains('active')) {
        searchInput.focus();
      }
    }
  });

  let searchData = [];

  fetch('/search.json')
    .then(response => response.json())
    .then(data => {
      searchData = data;
    })
    .catch(error => {
      console.error('Failed to load search data:', error);
    });

  searchInput.addEventListener('input', function() {
    const query = this.value.trim().toLowerCase();
    
    if (!query) {
      searchResults.innerHTML = '';
      return;
    }

    const results = searchData.filter(item => {
      const titleMatch = item.title.toLowerCase().includes(query);
      const contentMatch = item.content.toLowerCase().includes(query);
      const tagsMatch = item.tags.some(tag => tag.toLowerCase().includes(query));
      return titleMatch || contentMatch || tagsMatch;
    });

    displayResults(results);
  });

  function displayResults(results) {
    if (results.length === 0) {
      searchResults.innerHTML = '<div class="no-results">未找到匹配的文章</div>';
      return;
    }

    searchResults.innerHTML = results.slice(0, 10).map(item => `
      <div class="search-result-item">
        <a href="${item.url}" class="search-result-title">${item.title}</a>
        <p class="search-result-excerpt">${getExcerpt(item.content, item.title)}</p>
        <div class="search-result-meta">${item.date}</div>
      </div>
    `).join('');
  }

  function getExcerpt(content, title) {
    const text = content.replace(/<[^>]*>/g, '').substring(0, 150);
    return text.endsWith(' ') ? text.trim() : text.trim() + '...';
  }
});