---
title: Data
permalink: /data/
layout: home
---


## Accessibility Data

A page to showcase and enable downloading our data.


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



<style>
  .file-preview {
    width: 80%;
    max-width: 600px;
    border-collapse: collapse;
    margin: 20px 20px 20px 0;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    position: relative;
    overflow: hidden;
    border-radius: 10px;
    background-color: #ffffff;
    border: 2px solid #4caf50;
  }

  .file-preview th, .file-preview td {
    padding: 8px;
    text-align: left;
    border: 1px solid #4caf50;
    font-size: 12px;
  }

  .file-preview th {
    background-color: #ffffff;
    color: #333;
    font-weight: bold;
  }

  .file-preview tr:nth-child(even) {
    background-color: #f9f9f9;
  }

  .file-preview tr:hover {
    background-color: #f1f1f1;
  }

  .file-preview td {
    font-family: Arial, sans-serif;
    font-size: 12px;
    color: #555;
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