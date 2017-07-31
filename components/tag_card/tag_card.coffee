angular.module('loomioApp').directive 'tagCard', ($location, AppConfig, Records, ModalService, TagModal, AbilityService, LoadingService) ->
  scope: {group: '='}
  templateUrl: 'generated/components/tag_card/tag_card.html'
  controller: ($scope) ->
    $scope.parent = $scope.group.parentOrSelf()

    $scope.init = ->
      Records.tags.fetchByGroup($scope.parent)
    LoadingService.applyLoadingFunction $scope, 'init'
    $scope.init()

    $scope.showTagCard = ->
      $scope.canAdministerGroup() or
      _.any(Records.tags.find(groupId: $scope.parent.id))

    $scope.openTagForm = ->
      ModalService.open TagModal, tag: ->
        Records.tags.build(groupId: $scope.parent.id, color: AppConfig.pluginConfig('loomio_tags').config.colors[0])

    $scope.canAdministerGroup = ->
      AbilityService.canAdministerGroup($scope.parent)

    $scope.$on 'editTag', (e, tag) ->
      ModalService.open TagModal, tag: -> tag
