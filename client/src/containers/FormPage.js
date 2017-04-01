import React, {Component} from 'react';
import PageBase from '../components/PageBase';
import CustomInput from '../components/common/CustomInput';
import DatePicker from 'material-ui/DatePicker';
import RaisedButton from 'material-ui/RaisedButton';
import FlatButton from 'material-ui/FlatButton';
import Dropzone from 'react-dropzone';

const style = {
  dropzone: {
    position: 'relative',
    marginBottom: 20,
    marginTop: 20,
    cursor: 'pointer',
    textAlign: 'center',
    height: 100,
    border: '2px dashed grey',
  },
  dropzoneText: {
    position: 'absolute',
    top: '50%',
    left: '50%',
    transform: 'translate(-50%, -50%)',
    color: 'grey',
  }
};

class FormPage extends Component {

  onDrop() {
    console.log("drop");
  }

  render() {
    return (
      <PageBase title="Nova akcija"
                navigation="Application / Form Page">
        <form>
          <CustomInput hint="Naziv"/>
          <CustomInput hint="Opis"/>
          <DatePicker hintText="Početak akcije"/>
          <Dropzone onDrop={this.onDrop}
                    multiple={false}
                    style={style.dropzone}>
            <div style={style.dropzoneText}>Dovuci sliku unutar okvira ili klikni za odabir slike</div>
          </Dropzone>
          <RaisedButton label="Spremi" primary/>
          <FlatButton label="Odustani"/>
        </form>
      </PageBase>
    );
  }
}

export default FormPage;
