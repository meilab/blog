port module Stylesheets exposing (..)

import Css.File exposing (CssFileStructure, CssCompilerProgram)
import Styles.Home exposing (..)
import Styles.General exposing (..)


port files : CssFileStructure -> Cmd msg


fileStructures : CssFileStructure
fileStructures =
    Css.File.toFileStructure
        [ ( "/css/meilab.css"
          , Css.File.compile
                [ Styles.Home.css
                , Styles.General.css
                ]
          )
        ]


main : CssCompilerProgram
main =
    Css.File.compiler files fileStructures
