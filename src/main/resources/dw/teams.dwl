%dw 2.0
import * from dw::core::Strings
output application/json

var affectedComponents = payload.incident.incident_updates[0].affected_components map "$($.name) [**$($.new_status)**]"

fun getAffectedComponents() = 
    if(affectedComponents != null) "**Affected Components** <br/>"  ++ (affectedComponents joinBy " <br/>") else ""

fun getFacts() = 
    entriesOf(payload.incident)
    filter (["scheduled_for", "scheduled_until"] contains $.key as String)
    map
        {
            "name": capitalize($.key),
            "value": (($.value >> p("TimeZone") as TimeZone) as LocalDateTime as String { format: "yyyy/MM/dd(E) HH:mm" }) ++ " " ++ p("TimeZone")
        }

fun getColor(status) =
    status match {
        case "scheduled" -> "0094FF"
        case "update" -> "0094FF"
        case "completed" -> "0094FF"
        case "resolved" -> "0094FF"

        case "in_progress" -> "FFD800"
        case "monitoring" -> "FFD800"

        case "investigating" -> "FF3F3F"
        case "identified" -> "FF3F3F"

        else -> null
    }
---
{
    "@type": "MessageCard",
    "@context": "http://schema.org/extensions",
    themeColor: getColor(payload.incident.status),
    text: "**[$(payload.incident.name)]($(payload.incident.shortlink))**",
    sections: [
        {
            activityTitle: capitalize(payload.incident.status),
            activityText: payload.incident.incident_updates[0].body,
            text: getAffectedComponents(),
            facts: getFacts(),
            markdown: true
        }
    ]
}