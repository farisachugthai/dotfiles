# This script enables bash autocompletion for pandoc.  To enable
# bash completion, add this to your .bashrc:
# eval "$(pandoc --bash-completion)"

_pandoc()
{
    local cur prev opts lastc informats outformats datafiles
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # These should be filled in by pandoc:
    opts="-f -r --from --read -t -w --to --write -o --output --data-dir --base-header-level --strip-empty-paragraphs --indented-code-classes -F --filter --lua-filter -p --preserve-tabs --tab-stop --track-changes --file-scope --extract-media -s --standalone --template -M --metadata -V --variable -D --print-default-template --print-default-data-file --print-highlight-style --dpi --eol --wrap --columns --strip-comments --toc --table-of-contents --toc-depth --no-highlight --highlight-style --syntax-definition -H --include-in-header -B --include-before-body -A --include-after-body --resource-path --request-header --self-contained --html-q-tags --ascii --reference-links --reference-location --atx-headers --top-level-division -N --number-sections --number-offset --listings -i --incremental --slide-level --section-divs --default-image-extension --email-obfuscation --id-prefix -T --title-prefix -c --css --reference-doc --epub-subdirectory --epub-cover-image --epub-metadata --epub-embed-font --epub-chapter-level --pdf-engine --pdf-engine-opt --bibliography --csl --citation-abbreviations --natbib --biblatex --mathml --webtex --mathjax --katex --gladtex --abbreviations --trace --dump-args --ignore-args --verbose --quiet --fail-if-warnings --log --bash-completion --list-input-formats --list-output-formats --list-extensions --list-highlight-languages --list-highlight-styles -v --version -h --help"
    informats="commonmark creole docbook docx epub fb2 gfm haddock html jats json latex markdown markdown_github markdown_mmd markdown_phpextra markdown_strict mediawiki muse native odt opml org rst t2t textile tikiwiki twiki vimwiki"
    outformats="asciidoc beamer commonmark context docbook docbook4 docbook5 docx dokuwiki dzslides epub epub2 epub3 fb2 gfm haddock html html4 html5 icml jats json latex man markdown markdown_github markdown_mmd markdown_phpextra markdown_strict mediawiki ms muse native odt opendocument opml org plain pptx revealjs rst rtf s5 slideous slidy tei texinfo textile zimwiki"
    highlight_styles="pygments tango espresso zenburn kate monochrome breezedark haddock"
    datafiles="reference.docx reference.odt reference.pptx MANUAL.txt docx/_rels/.rels pptx/_rels/.rels make-reference-files.hs epub.css pandoc.List.lua bash_completion.tpl pandoc.lua abbreviations init.lua vimwiki.css sample.lua jats.csl odt/mimetype odt/manifest.rdf odt/styles.xml odt/meta.xml odt/content.xml odt/settings.xml odt/Thumbnails/thumbnail.png odt/Configurations2/accelerator/current.xml odt/META-INF/manifest.xml pptx/[Content_Types].xml pptx/docProps/core.xml pptx/docProps/app.xml pptx/ppt/tableStyles.xml pptx/ppt/presProps.xml pptx/ppt/viewProps.xml pptx/ppt/presentation.xml pptx/ppt/notesSlides/notesSlide2.xml pptx/ppt/notesSlides/notesSlide1.xml pptx/ppt/notesSlides/_rels/notesSlide2.xml.rels pptx/ppt/notesSlides/_rels/notesSlide1.xml.rels pptx/ppt/theme/theme1.xml pptx/ppt/theme/theme2.xml pptx/ppt/_rels/presentation.xml.rels pptx/ppt/notesMasters/notesMaster1.xml pptx/ppt/notesMasters/_rels/notesMaster1.xml.rels pptx/ppt/slideMasters/slideMaster1.xml pptx/ppt/slideMasters/_rels/slideMaster1.xml.rels pptx/ppt/slides/slide1.xml pptx/ppt/slides/slide2.xml pptx/ppt/slides/_rels/slide2.xml.rels pptx/ppt/slides/_rels/slide1.xml.rels pptx/ppt/slideLayouts/slideLayout10.xml pptx/ppt/slideLayouts/slideLayout2.xml pptx/ppt/slideLayouts/slideLayout4.xml pptx/ppt/slideLayouts/slideLayout11.xml pptx/ppt/slideLayouts/slideLayout6.xml pptx/ppt/slideLayouts/slideLayout8.xml pptx/ppt/slideLayouts/slideLayout1.xml pptx/ppt/slideLayouts/slideLayout7.xml pptx/ppt/slideLayouts/slideLayout5.xml pptx/ppt/slideLayouts/slideLayout3.xml pptx/ppt/slideLayouts/slideLayout9.xml pptx/ppt/slideLayouts/_rels/slideLayout4.xml.rels pptx/ppt/slideLayouts/_rels/slideLayout9.xml.rels pptx/ppt/slideLayouts/_rels/slideLayout11.xml.rels pptx/ppt/slideLayouts/_rels/slideLayout8.xml.rels pptx/ppt/slideLayouts/_rels/slideLayout10.xml.rels pptx/ppt/slideLayouts/_rels/slideLayout2.xml.rels pptx/ppt/slideLayouts/_rels/slideLayout3.xml.rels pptx/ppt/slideLayouts/_rels/slideLayout1.xml.rels pptx/ppt/slideLayouts/_rels/slideLayout6.xml.rels pptx/ppt/slideLayouts/_rels/slideLayout5.xml.rels pptx/ppt/slideLayouts/_rels/slideLayout7.xml.rels translations/et.yaml translations/fa.yaml translations/tr.yaml translations/lv.yaml translations/ro.yaml translations/rm.yaml translations/eo.yaml translations/fr.yaml translations/de.yaml translations/no.yaml translations/ar.yaml translations/en.yaml translations/lo.yaml translations/uk.yaml translations/it.yaml translations/is.yaml translations/vi.yaml translations/bg.yaml translations/ru.yaml translations/he.yaml translations/hu.yaml translations/bn.yaml translations/fi.yaml translations/es.yaml translations/km.yaml translations/nl.yaml translations/eu.yaml translations/ko.yaml translations/sq.yaml translations/hr.yaml translations/ca.yaml translations/el.yaml translations/lt.yaml translations/cs.yaml translations/hi.yaml translations/sk.yaml translations/sl.yaml translations/th.yaml translations/ur.yaml translations/am.yaml translations/sv.yaml translations/pt.yaml translations/sr-cyrl.yaml translations/da.yaml translations/sr.yaml translations/pl.yaml templates/default.opml templates/default.zimwiki templates/default.plain templates/default.s5 templates/default.latex templates/default.context templates/default.html5 templates/default.tei templates/default.revealjs templates/default.slidy templates/default.rst templates/default.haddock templates/default.epub3 templates/default.icml templates/default.rtf templates/default.man templates/default.asciidoc templates/default.docbook5 templates/default.dokuwiki templates/default.slideous templates/default.mediawiki templates/default.textile templates/default.org templates/default.jats templates/default.epub2 templates/default.docbook4 templates/default.ms templates/default.texinfo templates/default.dzslides templates/default.html4 templates/default.muse templates/default.markdown templates/README.markdown templates/default.opendocument templates/default.commonmark docx/[Content_Types].xml docx/docProps/core.xml docx/docProps/app.xml docx/word/footnotes.xml docx/word/document.xml docx/word/comments.xml docx/word/styles.xml docx/word/webSettings.xml docx/word/settings.xml docx/word/numbering.xml docx/word/fontTable.xml docx/word/theme/theme1.xml docx/word/_rels/document.xml.rels docx/word/_rels/footnotes.xml.rels dzslides/template.html"

    case "${prev}" in
         --from|-f|--read|-r)
             COMPREPLY=( $(compgen -W "${informats}" -- ${cur}) )
             return 0
             ;;
         --to|-t|--write|-w|-D|--print-default-template)
             COMPREPLY=( $(compgen -W "${outformats}" -- ${cur}) )
             return 0
             ;;
         --email-obfuscation)
             COMPREPLY=( $(compgen -W "references javascript none" -- ${cur}) )
             return 0
             ;;
         --pdf-engine)
             COMPREPLY=( $(compgen -W "pdflatex lualatex xelatex wkhtmltopdf weasyprint prince context pdfroff" -- ${cur}) )
             return 0
             ;;
         --print-default-data-file)
             COMPREPLY=( $(compgen -W "${datafiles}" -- ${cur}) )
             return 0
             ;;
         --wrap)
             COMPREPLY=( $(compgen -W "auto none preserve" -- ${cur}) )
             return 0
             ;;
         --track-changes)
             COMPREPLY=( $(compgen -W "accept reject all" -- ${cur}) )
             return 0
             ;;
         --reference-location)
             COMPREPLY=( $(compgen -W "block section document" -- ${cur}) )
             return 0
             ;;
         --top-level-division)
             COMPREPLY=( $(compgen -W "section chapter part" -- ${cur}) )
             return 0
             ;;
         --highlight-style)
             COMPREPLY=( $(compgen -W "${highlight_styles}" -- ${cur}) )
             return 0
             ;;
         *)
             ;;
    esac

    case "${cur}" in
         -*)
             COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
             return 0
             ;;
         *)
             local IFS=$'\n'
             COMPREPLY=( $(compgen -X '' -f "${cur}") )
             return 0
             ;;
    esac

}

complete -o filenames -o bashdefault -F _pandoc pandoc

