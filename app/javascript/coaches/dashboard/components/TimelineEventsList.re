let str = ReasonReact.string;

let component = ReasonReact.statelessComponent("TimelineEventsList");

let make =
    (
      ~timelineEvents,
      ~replaceTimelineEvent,
      ~authenticityToken,
      ~notAcceptedIconUrl,
      ~verifiedIconUrl,
      ~gradeLabels,
      ~passGrade,
      _children,
    ) => {
  ...component,
  render: _self =>
    <div className="timeline-events-list__container">
      (
        timelineEvents
        |> List.map(te =>
             <TimelineEventCard
               key=(te |> TimelineEvent.id |> string_of_int)
               timelineEvent=te
               replaceTimelineEvent
               authenticityToken
               notAcceptedIconUrl
               verifiedIconUrl
               gradeLabels
               passGrade
             />
           )
        |> Array.of_list
        |> ReasonReact.array
      )
    </div>,
};