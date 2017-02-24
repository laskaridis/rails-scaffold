$(document).ready ->
  $("form#new_message").on("ajax:success", (e, data, status, xhr) ->
    $("tbody#messages").prepend """
                                <tr>
                                  <td>
                                    <input type="checkbox"
                                           name="message_ids[]"
                                           id="message_ids_"
                                           value="#{ data.id }">
                                  </td>
                                  <td>#{ data.recipient }</td>
                                  <td>#{ data.subject }</td>
                                  <td>#{ data.created_at }</td>
                                </tr>
                                """
    $("#compose_message_modal").modal("hide")
  ).on "ajax:error", (e, xhr, status, error) ->
    console.log xhr.responseText
