module Dictionary exposing (..)


type Dictionary
    = Nrk
    | Erotics


getUrl : Dictionary -> String
getUrl dict =
    case dict of
        Nrk ->
            "nrk.json"

        Erotics ->
            "erotikk.json"
