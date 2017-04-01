import React, { Component, PropTypes } from 'react';
import TextField from 'material-ui/TextField';

const CustomInput = ({ input, label, hint, type = 'text'}) => {
  return(
    <div>
      <TextField
        hintText={hint}
        floatingLabelText={label}
        floatingLabelFixed
        type={type}
        fullWidth
        {...input}/>
    </div>
  );
};

CustomInput.propTypes = {
  input: PropTypes.object,
  label: PropTypes.string,
  hint: PropTypes.string,
  type: PropTypes.string,
  required: PropTypes.bool,
  floatingLabel: PropTypes.bool,
};

export default CustomInput;
