angular.module('loomioApp').directive 'tagDropdown', (ModalService, AppConfig, TagModal, Records, AbilityService, FormService)->
  scope: {discussion: '='}
  restrict: 'E'
  templateUrl: 'generated/components/tag_dropdown/tag_dropdown.html'
  controller: ($scope) ->
    $scope.openTagForm = ->
      ModalService.open TagModal, tag: ->
        Records.tags.build(groupId: $scope.groupId(), color: AppConfig.pluginConfig('loomio_tags').config.colors[0])

    $scope.groupId = ->
      $scope.discussion.group().parentOrSelf().id

    $scope.hasTags = ->
      _.any(Records.tags.find(groupId: $scope.groupId()))

    return
