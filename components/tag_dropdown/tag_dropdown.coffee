angular.module('loomioApp').directive 'tagDropdown', ->
  scope: {discussion: '='}
  restrict: 'E'
  templateUrl: 'generated/components/tag_dropdown/tag_dropdown.html'
  controller: ($scope, Records, AbilityService, FormService) ->
    $scope.hasTags = ->
      return false unless $scope.discussion.group()
      _.any(Records.tags.find(groupId: $scope.discussion.group().parentOrSelf().id))

    return
