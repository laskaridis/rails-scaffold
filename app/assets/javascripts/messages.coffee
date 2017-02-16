$(document).ready ->
  $("form#new_message").on("ajax:success", (e, data, status, xhr) ->
    $("#compose_message_modal").modal("hide")

    $("tbody#messages").prepend """
                                <tr>
                                  <td>#{ data.recipient.full_name }</td>
                                  <td>#{ data.subject }</td>
                                  <td>#{ data.created_at }</td>
                                </tr>
                                """
  ).on "ajax:error", (e, xhr, status, error) ->
    console.log xhr.responseText
