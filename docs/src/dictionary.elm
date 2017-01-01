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

getDescription : Dictionary -> String
getDescription dict = 
    case dict of
        Nrk ->
            "nrk.no"

        Erotics ->
            "noveller.no"
