===========================
What worked and what didn't
===========================

.. module:: ctags


Yeah this might literally just be the output of ``ctags --list-*`` for a while.

....though admittedly that might take a while....

--list-aliases=[language|all] Output list of alias patterns.

--list-excludes Output list of exclude patterns for excluding files/directories.

--list- extras=[language|all] Output list of extra tag flags.

--list-features Output list of compiled features.

--list-fields=[language|all] Output list of fields.

--list- 
kinds=[language|all]                                                                                                                   
Output a list of all tag kinds for specified language or

all.
--list-kinds-
full=[language|all]                                                                                                                 
List the details of all tag kinds for specified language or
 all                                                                                 For each line, associated language name is printed when "all" is                                                                                specified as
 language.                                                                                                                     --list-
 languages                                                                                                                                     Output list of supported
 languages.                                                                                                        --list-map-
 extensions=[language|all]                                                                                                                 Output list of language extensions in
 mapping.                                                                                             --list-map-patterns=[language|all]
 Output list of language patterns in mapping.                                                                                               --list-
 maps=[language|all]                                                                                                                           Output list of language mappings(both extensions and
 patterns).                                                                            --list-mline-regex-flags                                                                                                                             Output list of flags which can be used in a multiline regex parser
 definition.                                                             --list-params=[language|all]                                                                                                                         Output list of language parameters. This works with --
 machinable.                                                                          --list-pseudo-tags                                                                                                                                   Output list of pseudo
 tags.                                                                                                                --list-regex-
 flags                                                                                                                                   Output list of flags which can be used in a regex parser
 definition.                                                                       --list-roles=[[language|all].[kindspecs|*]]
 Output list of all roles of tag kind(s) specified for language(s).                                                                              Both letters and names can be used in
 kindspecs.                                                                                                e.g. --list-roles=C.{header}d
 --list-subparsers=[baselang|all]                                                                                                                     Output list of subparsers for the base
 language.                                                                                           --machinable=[yes|no]


Aliases
=========

The output of ``ctags --list-aliases`` showed a seeming filetype : filetype
mapping. So this didn't seem to match the others at all.

# --alias-python=*.ipy


Excludes
=========
Unnecessary excludes.

 ``ctags --list-excludes``



 .. option:: --exclude

   Comes with .git built-in!


