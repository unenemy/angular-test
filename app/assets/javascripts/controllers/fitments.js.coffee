app = angular.module("TestApi", ["ngResource"])

@FitmentsCtrl = ($scope, $resource)->
  Year = $resource("/api_get/years")
  Make = $resource("/api_get/years/:year_id/makes")
  Model = $resource("/api_get/years/:year_id/makes/:make_id/models")
  Option = $resource("/api_get/years/:year_id/makes/:make_id/models/:model_id/options")
  Fitment = $resource("/api_get/years/:year_id/makes/:make_id/models/:model_id/options/:option_id/fitments")
  $scope.years = Year.query()
  $scope.makes = []
  $scope.models = []
  $scope.options = []

  $scope.$watch "makes", ->
    $scope.makesDisabled = $scope.makes.length == 0
  ,true

  $scope.$watch "options", ->
    $scope.optionsDisabled = $scope.options.length == 0
  ,true

  $scope.$watch "models", ->
    $scope.modelsDisabled = $scope.models.length == 0
  ,true

  $scope.$watch "years", ->
    $scope.yearsDisabled = $scope.years.length == 0
  ,true

  $scope.getMakes = ->
    if $scope.selectedYear
      $scope.makes = Make.query({year_id: $scope.selectedYear})
    $scope.selectedMake = null
    $scope.selectedModel = null
    $scope.selectedOption = null
    $scope.showFitments = false
    $scope.models = []
    $scope.options = []

  $scope.getModels = ->
    if $scope.selectedMake
      $scope.models = Model.query({year_id: $scope.selectedYear, make_id: $scope.selectedMake})
    $scope.selectedModel = null
    $scope.options = []
    $scope.showFitments = false

  $scope.getOptions = ->
    if $scope.selectedModel
      $scope.options = Option.query
        year_id: $scope.selectedYear
        make_id: $scope.selectedMake
        model_id: $scope.selectedModel

    $scope.selectedOption = null
    $scope.showFitments = false

  $scope.getFitments = ->
    if $scope.selectedOption
      $scope.fitments = Fitment.query(
        year_id: $scope.selectedYear
        make_id: $scope.selectedMake
        model_id: $scope.selectedModel
        option_id: $scope.selectedOption)
      $scope.showFitments = true






