module Styles.SharedStyles exposing (..)

import Html.CssHelpers exposing (withNamespace)


type CssClass
    = Layout
    | Header
    | Body
    | ContentContainer
    | Footer
    | MenuContainer
    | MenuList
    | HeaderMenuList
    | MenuItem
    | MenuSelected
    | ImgResponsive
    | ContentMeta
    | MarkdownWrapper
    | MarkdownContent
    | SubContent


meilabNamespace : Html.CssHelpers.Namespace String class id msg
meilabNamespace =
    withNamespace "meilab"
