class window.SpinnerLoader

  constructor : (target) ->

    opts = {
      lines: 12,
      length: 5,
      width: 1,
      radius: 5,
      rotate: 0,
      corners: 1,  
      color: '#000',
      direction: 1,
      speed: 1,
      trail: 100, 
      opacity: 1/4,
      fps: 20,
      zIndex: 2e9,   
      className: 'spinner',
      top: '50%',   
      left: '95%', 
      position: 'absolute'
    }

    @spinner = new Spinner(opts)
    @target  = target

  spin : () ->
    @spinner.spin(@target)

  stop : () ->
    @spinner.stop()