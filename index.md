---
layout: home
title: Home
---

<div class='title-panel'>
<div class='title'>
    Accessibility Database of Life Science Data Resources
</div>
<div class='subtitle'>
    An open database and data portal for storing and keeping track of the digital accessibility of life science data resources.
</div>
</div>

<div id='visual-statistics'>
    <div id='statistics-num-pages'></div>
    <div></div>
</div>

## Publications

Sehi L'Yi, Thomas C Smits, Alexander Lex, Nils Gehlenborg, 
Digital Accessibility of Life Sciences Data Portals and Journal Websites, 
OSF Preprints, 10.31219/osf.io/5v98j

<script type="text/javascript">

    const numPages = "{{ "/assets/plots/statistics-num-pages.json" | relative_url }}";
    
    const vegaOptions = {
        renderer: "canvas",
        actions: true,
    };

    window.onload = () => {
        vegaEmbed(
            `#statistics-num-pages`,
            numPages,
            vegaOptions
        );
    }
</script>
