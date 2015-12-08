import { Socket } from 'phoenix';

export default {
   configureChannel() {
    let socket = new Socket('/ws');
    socket.connect();

    let channel = socket.channel('texts');

    console.log('Joining texts channel');

    channel.join()
      .receive('ok', messages => console.log('catching up', messages))
      .receive('error', reason => console.log('failed join', reason))
      .after(10000, () => console.log('Networking issue. Still waiting...'));

    return channel;
  }
}
