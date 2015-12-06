import { Socket } from 'phoenix';

export function configureChannel() {
  let socket = new Socket('/ws');
  socket.connect();

  let channel = socket.channel('todos');

  channel.on('new:todo', msg => console.log('new:todo', msg));

  channel.join()
    .receive('ok', messages => console.log('catching up', messages))
    .receive('error', reason => console.log('failed join', reason))
    .after(10000, () => console.log('Networking issue. Still waiting...'));
}
