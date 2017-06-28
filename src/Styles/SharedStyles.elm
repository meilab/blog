module Styles.SharedStyles exposing (..)

import Html.CssHelpers exposing (withNamespace)


type CssClass
    = Layout
    | Body
    | Hero
    | ContentContainer
    | MenuContainer
    | MenuList
    | HeaderMenuList
    | MenuItem
    | MenuLink
    | MenuSelected
    | ImgResponsive
    | ContentMeta
    | MarkdownWrapper
    | MarkdownContent
    | SubContent
    | TrainingContainer
    | TrainingItem
    | AuthorContainer
    | AuthorItem
    | AuthorMeta
    | Spacing
      -- Header and Footer
    | Header
    | Footer
      -- For Post
    | PostHero
    | BlogPost


meilabNamespace : Html.CssHelpers.Namespace String class id msg
meilabNamespace =
    withNamespace "meilab"
