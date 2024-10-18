---
title: Data
permalink: /data/
layout: home
---


## Accessibility Data

A page to showcase and enable downloading our data.

### Files

<ul class="file-list">
  {% assign csv_files = site.static_files | where_exp: "file", "file.path contains '/assets/csv/' and file.extname == '.csv'" %}
  {% for file in csv_files %}
    <li class="file-item">
      <div class="file-header">
        <span class="file-title">{{ file.name }}</span>
        <button aria-expanded="false" aria-controls="file-content-{{ forloop.index }}" class="toggle-button" onclick="toggleContent('{{ forloop.index }}', '{{ file.path | relative_url }}')">
          <span class="visually-hidden">Expand section for {{ file.name }}</span>
          <img id="icon-{{ forloop.index }}" src="{{ '/assets/icons/plus.svg' | relative_url }}" alt="Expand section for {{ file.name }}" width="24" height="24">
        </button>
        <a href="{{ file.path | relative_url }}" download class="download-link">
          <span class="visually-hidden">Download {{ file.name }}</span>
          <img src="{{ '/assets/icons/download.svg' | relative_url }}" alt="Download {{ file.name }}" width="24" height="24">
        </a>
      </div>
      <div id="file-content-{{ forloop.index }}" class="file-content" hidden>
        <table class="file-preview">
        </table>
      </div>
    </li>
  {% endfor %}
</ul>

### Top Issues
<a href="{{ '/data/top-issues.csv' | relative_url }}" class="download-button" download>
  Download CSV
</a>

<table class="file-preview">
  {% assign limited_rows = site.data.top-issues | slice: 0, 5 %}
  {% for row in limited_rows %}
    {% if forloop.first %}
    <tr>
      {% for pair in row %}
        <th>{{ pair[0] }}</th>
      {% endfor %}
    </tr>
    {% endif %}

    {% tablerow pair in row %}
      {{ pair[1] }}
    {% endtablerow %}
  {% endfor %}
</table>

## Publications

Sehi L'Yi, Thomas C Smits, Alexander Lex, Nils Gehlenborg, 
Digital Accessibility of Life Sciences Data Portals and Journal Websites, 
OSF Preprints, 10.31219/osf.io/5v98j


<script>
  function fetchCSVFiles(filePaths) {
    return Promise.all(
      filePaths.map(path => 
        fetch(path).then(response => response.text())
      )
    );
  }

  function toggleContent(id, filePath) {
    const content = document.getElementById(`file-content-${id}`);
    const button = document.querySelector(`[aria-controls="file-content-${id}"]`);
    const icon = document.getElementById(`icon-${id}`);
    
    const isExpanded = button.getAttribute("aria-expanded") === "true";
    
    // change aria state
    button.setAttribute("aria-expanded", !isExpanded);
    content.hidden = isExpanded;

    // Update hidden button text for screen readers
    const srText = button.querySelector('.visually-hidden');
    srText.textContent = isExpanded ? `Expand section for File${id}` : `Collapse section for File${id}`;

    // change icons
    icon.src = isExpanded 
      ? "{{ '/assets/icons/plus.svg' | relative_url }}" 
      : "{{ '/assets/icons/minus.svg' | relative_url }}";
    
    // check if expanded, else, fetch content
    if (!isExpanded && !content.getAttribute('data-loaded')) {
      fetch(filePath)
        .then(response => response.text())
        .then(csvText => {
          const rows = csvText.split('\n').slice(0, 5); // max 5 rows
          const table = content.querySelector('table');
          let tableHTML = '';
          
          rows.forEach((row, rowIndex) => {
            const columns = row.split(',');
            tableHTML += '<tr>';
            columns.forEach(column => {
              if (rowIndex === 0) {
                tableHTML += `<th>${column}</th>`;
              } else {
                tableHTML += `<td>${column}</td>`;
              }
            });
            tableHTML += '</tr>';
          });
          
          table.innerHTML = tableHTML;
          content.setAttribute('data-loaded', 'true');
        })
        .catch(error => console.error('Error fetching CSV file:', error));
    }
  }
</script>


<style>
  .visually-hidden {
    position: absolute;
    width: 1px;
    height: 1px;
    margin: -1px;
    padding: 0;
    overflow: hidden;
    clip: rect(0, 0, 0, 0);
    border: 0;
  }

  .toggle-button, .download-link {
    background-color: transparent;
    border: none;
    cursor: pointer;
    display: inline-flex;
    padding: 10px;
  }

  .toggle-button:hover, .toggle-button:focus, 
  .download-link:hover, .download-link:focus {
    outline: 3px solid #005fcc;
  }

  .file-preview {
    width: 80%;
    max-width: 600px;
    border-collapse: collapse;
    margin: 20px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    position: relative;
    overflow: hidden;
    border-radius: 10px;
    background-color: #ffffff;
    border: 2px solid #4caf50;
    font-size: 12px;
  }

  .file-preview th, .file-preview td {
    padding: 8px;
    text-align: left;
    border: 1px solid #4caf50;
  }

  .file-preview th {
    color: #333333;
    font-weight: bold;
  }

  .file-preview tr:nth-child(even) {
    background-color: #f9f9f9;
  }

  .file-preview tr:hover {
    background-color: #f1f1f1;
  }

  .file-preview td {
    color: #555555;
  }

  .file-preview::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 200px;
    background: linear-gradient(to bottom, rgba(255, 255, 255, 0) 0%, rgba(255, 255, 255, 1) 100%);
    pointer-events: none;
  }

  .download-button {
    display: inline-block;
    padding: 10px 15px;
    margin-top: 10px;
    background-color: #4caf50;
    color: white;
    border: none;
    border-radius: 5px;
    text-decoration: none;
    font-size: 14px;
  }

  .download-button:hover {
    background-color: #45a049;
  }
</style>