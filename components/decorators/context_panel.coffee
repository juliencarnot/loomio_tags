angular.module('loomioApp').config ($provide) ->
  $provide.decorator 'contextPanelDirective', ($delegate, Records, ModalService, TagApplyModal) ->
    $delegate[0].compile = ->
      (scope) ->
        Records.tags.fetchByGroup(scope.discussion.group().parentOrSelf())
        scope.actions.unshift
          name: 'tag_thread'
          icon: 'mdi-tag'
          canPerform: -> _.any Records.tags.find(groupId: scope.discussion.group().parentOrSelf().id)
          perform:    -> ModalService.open TagApplyModal, discussion: -> scope.discussion
        $delegate[0].link.apply(this, arguments) if $delegate[0].link
    $delegate
