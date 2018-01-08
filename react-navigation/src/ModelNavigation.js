/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, {Component} from 'react';
import {
    View,
    Text,
    TouchableOpacity,
    StyleSheet,
} from 'react-native';

export default class ModelNavigation extends Component {

    render() {
        console.log(this.props.navigation);
        console.log(this.props.navigation.state);
        return(
            <View style={styles.container}>
                <TouchableOpacity onPress={()=>{
                    this.props.navigation.goBack('Profile');
                }}>
                    <Text>返回到第一个界面</Text>
                </TouchableOpacity>

            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex:1,
        justifyContent:'center',
        alignItems:'center'
    }
});