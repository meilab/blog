port module Stylesheets exposing (..)

import Css.File exposing (CssFileStructure, CssCompilerProgram)
import Styles.HomeCss exposing (..)


port files : CssFileStructure -> Cmd msg


fileStructures : CssFileStructure
fileStructures =
    Css.File.toFileStructure
        [ ( "/css/meilab.css"
          , Css.File.compile
                [ Styles.HomeCss.css ]
          )
        ]


main : CssCompilerProgram
main =
    Css.File.compiler files fileStructures
