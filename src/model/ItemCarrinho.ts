import { Table, Column, Model, ForeignKey } from 'sequelize-typescript';
import { loja } from './Loja';
import { usuario } from './Usuario';
import { produto } from './Produto';

@Table
export class item_carrinho extends Model {
  @Column({ primaryKey: true, autoIncrement: true })
  id_item: number;

  @ForeignKey(() => usuario)
  @Column
  fk_id_CarrinhoUser: number;

  @ForeignKey(() => produto)
  @Column
  fk_id_Produto: number;

  @ForeignKey(() => loja)
  @Column
  fk_id_Loja: number;

  @Column
  qnt_Produto: number;

  @Column
  valor_un: number;
}
