port module Stylesheets exposing (..)

import Css.File exposing (CssFileStructure, CssCompilerProgram)
import Styles.General exposing (..)
import Styles.HeaderFooter exposing (..)
import Styles.Post exposing (..)
import Styles.TagArchive exposing (..)


port files : CssFileStructure -> Cmd msg


fileStructures : CssFileStructure
fileStructures =
    Css.File.toFileStructure
        [ ( "/css/meilab.css"
          , Css.File.compile
                [ Styles.General.css
                , Styles.HeaderFooter.css
                , Styles.Post.css
                , Styles.TagArchive.css
                ]
          )
        ]


main : CssCompilerProgram
main =
    Css.File.compiler files fileStructures
