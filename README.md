# simple_text_form_field

Plugin to create a simple text_form_field for iOS and Android, Windows, and Web. This package contains several custom widget, such as : 
1. ```SimpleTextFormField```. for create simple textfield widget
2. ```SimpleTextFormFieldDate```. for create simple date picker or time picker widget
3. ```SimpleTextFormFieldDropDown```. for create generic dropdown widget
<br><br>
<div align="center">
<img src="https://raw.githubusercontent.com/griajobag/simple_text_form_field/main/web.png"/>
       <br>
<img src="https://raw.githubusercontent.com/griajobag/simple_text_form_field/main/windows.png"/>
       <br>
<img src="https://raw.githubusercontent.com/griajobag/simple_text_form_field/main/mobile.png"/>
</div>


## Usage

To use this plugin, add ```simple_text_form_field``` as
a [dependency in your pubspec.yaml](https://flutter.io/platform-plugins/).

### Example

```
       SimpleTextFormField(
              controller: controller,
              isRequired: true,
              errorTextSize: 8,
              maxLength: 12,
              label: "Name",
              placeHolder: "Input your name",
            ),
            
        SimpleTextFormFieldDate(
          isRequired: true,
          fillColor: Colors.transparent,
          controller: controllerDate,
          firstDate: DateTime.now(),
          label: "Your Date",
        ),
        
        SimpleTextFormFieldDate(
          isRequired: true,
          fillColor: Colors.transparent,
          controller: controllerTime,
          type: InputDatetimeType.time,
          label: "Your Time",
        ),
        
        SimpleTextFormFieldDropDown<ItemModel>(
          controller: controllerDropdown,
          required: true,
          label: "Select one",
          valueItem: (e)=> e.mainTitle!,
          listItem: lists,
        ),
```

and to to get value or do some validations just do like the following code :

```
    if (controller.isValid &&
          controllerDate.isValid &&
          controllerTime.isValid &&
      controllerDropdown.isValid) {
        setState(() {
          text = controller.value;
          date = SimpleConstants.dateToString(controllerDate.value,
              format: "dd/MM/yyyy");
          time = controllerTime.value.format(context);
        });
      }
```

