module Styles.SharedStyles exposing (..)

import Html.CssHelpers exposing (withNamespace)


type CssClass
    = Layout
    | Container
    | PostPreview
    | PostPreviewMeta
    | PostPreviewTitle
    | PostPreviewSubtitle
    | PostContentPreview
    | ContentContainer
    | Body
    | HomePageHero
    | SideBarWrapper
    | SideBarMenu
    | MenuContainer
    | MenuContainerVertical
    | MenuList
    | MenuListVertical
    | HeaderMenuList
    | MenuItem
    | MenuLink
    | MenuSelected
    | MenuActive
    | MenuInActive
    | MenuToggler
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
    | TagContainer
    | TagItem
    | TagItemActive
    | Searcher
      -- Header and Footer
    | Header
    | HeaderNavWrapper
    | HeaderNav
    | Footer
    | CopyRight
    | GithubIframe
      -- For Post
    | MorePostsLink
    | PostHero
    | BlogPost
    | PostHead


meilabNamespace : Html.CssHelpers.Namespace String class id msg
meilabNamespace =
    withNamespace "meilab"
