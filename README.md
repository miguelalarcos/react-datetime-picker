react-datetime-pcicker
======================
A date-time picker for React.

Example of use:
---------------

```cjsx
A = ReactMeteor.createClass
    mixins: [changedatemx]
    getInitialState: ->
        date: moment()
        date2: moment()
    templateName: 'A'
    render: ->
        <div>
            <DateTimePicker changeData=this.changeDate('date') value=this.state.date time=true format='DD-MM-YYYY HH:mm'/>
            <DateTimePicker changeData=this.changeDate('date2') value=this.state.date2 time=false format='DD-MM-YYYY'/>
        </div>
```

ChangeData is a callback to modify the date from a child.