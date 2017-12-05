describe 'discussion tags', ->
  page = require '../../../../../angular/test/protractor/helpers/page_helper.coffee'

  describe 'creating a tag', ->
    it 'can create a tag for a group and a discussion', ->
      page.loadPath 'setup_group_on_paid_plan'
      page.click '.tag-form__create-tag'
      page.fillIn '.tag-form__name', 'Tag Name'
      page.click  '.tag-form__submit'
      page.expectText '.tag-list__link', 'Tag Name'

    it 'fetches tags when loading tags page', ->
      page.loadPath 'visit_tags_page'
      page.expectText '.thread-preview__text-container', 'This thread is public'

    it 'can create a discussion tag for a discussion', ->
      page.loadPath 'setup_group_on_paid_plan'
      page.click '.tag-form__create-tag'
      page.fillIn '.tag-form__name', 'Tag Name'
      page.click  '.tag-form__submit'
      page.clickFirst '.thread-preview__link'

      page.click '.action-dock__button--tag_thread'
      page.click '.tag-list__toggle'
      page.click '.tag-apply-modal__submit'
      page.expectText '.thread-tag', 'Tag Name'

    it 'does not allow non-coordinators to create tags', ->
      page.loadPath 'setup_group_on_paid_plan_as_non_coordinator'
      page.expectNoElement '.tag-form__create-tag'

    it 'serializes tags in the inbox', ->
      page.loadPath 'setup_inbox_with_tag'
      page.expectText '.thread-tag', 'Tag Name'

    it 'is visible to visitors', ->
      page.loadPath 'view_discussion_as_visitor_with_tags'
      page.expectText '.thread-tag', 'Tag Name'
