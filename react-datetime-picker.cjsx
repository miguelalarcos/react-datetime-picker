DTP = {}

dayRow = (week, date)->
  ret = []
  day = date.clone()
  ini_month = day.clone().startOf('Month')
  ini = day.clone().startOf('Month').add(1-ini_month.isoWeekday(), 'days')

  ini = ini.add(week, 'weeks')

  dt = ini_month.clone().add(1, 'month')
  if ini.isAfter(dt) or ini.isSame(dt)
    return []
  end = ini.clone().add(6, 'days')

  range = moment.range(ini, end)
  range.by 'day', (m) ->
    if ini_month.format('MM') == m.format('MM')
      if m.isSame(moment().startOf('day'))
        decoration = 'xbold xunderline xtoday xdatetime-day'
      else
        decoration = 'xbold xdatetime-day'
    else
      decoration = 'xcursive xdatetime-day'

    ret.push {value: m.format('DD'), date: m, decoration: decoration}

  ret

week = -> [0...6]

day = (week, m) ->
    dayRow(week, m)

Day =  React.createClass
    mixins: []
    click: (e) ->
        this.props.changeData(this.props.data.date)
        @props.show()
        e.preventDefault()
    render: ->
        <span onClick=this.click className={this.props.data.decoration} >{this.props.data.value}</span>


Week = React.createClass
    mixins: []
    render: ->
        <div className="xdatetime-week">
            {for x in day(this.props.week, this.props.m)
                <Day show=@props.show key=x.date data=x changeData=this.props.changeData></Day>
            }
        </div>


DTP.DateTimePicker = React.createClass
    mixins: []
    showCalendar: -> this.setState show: not this.state.show
    getInitialState: ->
        show: false
    minusMonth: (e)->
         d = moment(this.props.value) #.clone()
         d.subtract(1, 'months')
         this.props.changeData(d)
         e.preventDefault()
    plusMonth: (e)->
         d = moment(this.props.value) # this.props.value.clone()
         d.add(1, 'months')
         this.props.changeData(d)
         e.preventDefault()
    minusYear: (e)->
         d = moment(this.props.value) #this.props.value.clone()
         d.subtract(1, 'years')
         this.props.changeData(d)
         e.preventDefault()
    plusYear: (e)->
         d = moment(this.props.value) # this.props.value.clone()
         d.add(1, 'years')
         this.props.changeData(d)
         e.preventDefault()
    plusMinute: (e) ->
         d = moment(this.props.value) #this.props.value.clone()
         d.add(1, 'minutes')
         this.props.changeData(d)
         e.preventDefault()
    minusMinute: (e) ->
         d = moment(this.props.value) # this.props.value.clone()
         d.subtract(1, 'minutes')
         this.props.changeData(d)
         e.preventDefault()
    plusHour: (e) ->
         d = moment(this.props.value) # this.props.value.clone()
         d.add(1, 'hours')
         this.props.changeData(d)
         e.preventDefault()
    minusHour: (e) ->
         d = moment(this.props.value) # this.props.value.clone()
         d.subtract(1, 'hours')
         this.props.changeData(d)
         e.preventDefault()
    render: ->
      if this.state.show
        <div className='xdatetime'>
            <input type='text' onClick={this.showCalendar} value={moment(this.props.value).format(this.props.format)}/>
            <div className="xdatetime-popover">
                <div className="xdatetime-header">
                <i onClick=this.minusMonth className="ion-minus minus-month"></i>
                <span>&nbsp;&nbsp;</span>
                {moment(this.props.value).format('MM')}
                <span>&nbsp;&nbsp;</span>
                <i  onClick=this.plusMonth className="ion-plus plus-month"></i>
                <span>&nbsp;&nbsp;</span>
                <i  onClick=this.minusYear className="ion-minus minus-year"></i>
                <span>&nbsp;&nbsp;</span>
                {moment(this.props.value).format('YYYY')}
                <span>&nbsp;&nbsp;</span>
                <i  onClick=this.plusYear className="ion-plus plus-year"></i>
                </div>
                {<Week show=@showCalendar m=moment(this.props.value) key=w week=w changeData=this.props.changeData></Week> for w in week()}
                {if this.props.time
                    <div className="xdatetime-bottom">
                        <i onClick=this.minusHour className="ion-minus minus-hour"></i>
                        <span>&nbsp;&nbsp;</span>
                        <i onClick=this.plusHour className="ion-plus plus-hour"></i>
                        <span>&nbsp;&nbsp;</span>
                        <span >{moment(this.props.value).format('HH:mm')}</span>
                        <span>&nbsp;&nbsp;</span>
                        <i onClick=this.minusMinute className="ion-minus minus-minute"></i>
                        <span>&nbsp;&nbsp;</span>
                        <i onClick=this.plusMinute className="ion-plus plus-minute"></i>
                    </div>
                }
            </div>
        </div>
      else
        <input type='text' onClick={this.showCalendar} value={moment(this.props.value).format(this.props.format)} />

DTP.changeDataMx =
    changeDate: (name) ->
        self = this
        (date) ->
              hour = date.hour()
              minute = date.minute()
              if not hour and not minute
                  date.hour(moment(self.state[name]).hour())
                  date.minute(moment(self.state[name]).minute())
              #
              path = name.split('.')
              last = path[-1..][0]

              dct = {}
              dct_ = dct
              for p in path
                if p == last
                    dct[p] = {$set: date.toDate()}
                else
                    dct[p] = {}
                dct = dct[p]


              self.setState(React.addons.update(self.state, dct_))


