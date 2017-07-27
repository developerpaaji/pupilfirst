stopVideosOnModalClose = ->
  $('.video-modal').on 'hide.bs.modal', (event) ->
    modalIframe = $(event.target).find('iframe')
    modalIframe.attr 'src', modalIframe.attr('src')

$(document).on 'page:change', stopVideosOnModalClose

# !!! NEW STUFF !!!
expandFramework = ->
  $('.program-framework__timeline-title').click (e) ->
    $(this).next().slideToggle()
    $(this).toggleClass('active')

faqCollapse = ->
  $('.collapse.in').prev('.apply-faq__collapse-card-header').addClass 'active'
  $('.apply-faq__collapse').on('show.bs.collapse', (a) ->
    $(a.target).prev('.apply-faq__collapse-card-header').addClass 'active')
  $('.apply-faq__collapse').on('hide.bs.collapse', (a) ->
    $(a.target).prev('.apply-faq__collapse-card-header').removeClass 'active')

setupSelect2Inputs = ->
  collegeInput = $('#founders_registration_college_id')

  if collegeInput.length == 0
    collegeInput = $('#prospective_applicants_registration_college_id')

  if collegeInput.length
    collegeSearchUrl = collegeInput.data('searchUrl')

    collegeInput.select2
      minimumInputLength: 3,
      placeholder: 'Please pick your college',
      ajax:
        url: collegeSearchUrl,
        dataType: 'json',
        delay: 500,
        data: (params) ->
          return {
            q: params.term
          }
        ,
        processResults: (data, params) ->
          return { results: data }
        cache: true

destroySelect2Inputs = ->
  collegeInput = $('#founders_registration_college_id')

  if collegeInput.length == 0
    collegeInput = $('#prospective_applicants_registration_college_id')

  if collegeInput.length
    collegeInput.select2('destroy')
    collegeInput.val('')

toggleReferenceTextField = ->
  if $('#founders_registration_reference').val() == 'Other (Please Specify)'
    referenceTextInput = $('#founders_registration_reference_text')
    referenceTextInput.parent().parent().removeClass('hidden-xs-up')
    $('#founders_registration_reference').parent().addClass('hidden-xs-up')
    referenceTextInput.focus()

setupTogglingReferenceField = ->
  if $('#founders_registration_reference').length
    toggleReferenceTextField()
    $('#founders_registration_reference').change toggleReferenceTextField

toggleCollegeTextField = ->
  formName = null

  if $('#founders_registration_college_id').val() == 'other'
    formName = 'founders_registration'
  else if $('#prospective_applicants_registration_college_id').val() == 'other'
    formName = 'prospective_applicants_registration'

  if formName != null
    collegeTextInput = $("##{formName}_college_text")
    collegeTextInput.prop('disabled', false)
    collegeTextInput.parent().parent().removeClass('hidden-xs-up')
    $("##{formName}_college_id").parent().addClass('hidden-xs-up')
    collegeTextInput.focus()

setupTogglingCollegeField = ->
  collegeInput = $('#founders_registration_college_id')

  if collegeInput.length == 0
    collegeInput = $('#prospective_applicants_registration_college_id')

  if collegeInput.length
    toggleCollegeTextField()
    collegeInput.change toggleCollegeTextField

helpIntercomPopup = ->
  $(".help-intercom-link").click (e) ->
    e.preventDefault()
    Intercom('show')

setupPasswordHintButtons = ->
  $('#application-form__password-hint-accept').on('click', replaceEmailWithHint)
  $('#application-form__password-hint-reject').on('click', acceptEmailInputfromUser)

replaceEmailWithHint = (event) ->
  $('#founders_registration_email').val($('#founders_registration_email').data('replacementHint'))
  event.preventDefault()
  $(event.target).closest('.help-block').slideUp()

acceptEmailInputfromUser = (event) ->
  $('#founders_registration_ignore_email_hint').val('true')
  event.preventDefault()
  $(event.target).closest('.help-block').slideUp()



$(document).on 'page:change', setupTogglingCollegeField
$(document).on 'page:change', setupTogglingReferenceField
$(document).on 'page:change', helpIntercomPopup
$(document).on 'page:change', expandFramework
$(document).on 'page:change', faqCollapse

$(document).on 'turbolinks:load', ->
  if $('#admissions__apply').length
    setupSelect2Inputs()
    setupPasswordHintButtons()

$(document).on 'turbolinks:before-cache', ->
  if $('.admission-process').length
    destroySelect2Inputs()