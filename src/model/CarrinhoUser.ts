import { Table, Column, Model, ForeignKey } from 'sequelize-typescript';
import { usuario } from './Usuario';

@Table
export class carrinho_user extends Model {
  @Column({ primaryKey: true, autoIncrement: true })
  id_carrinho: number;

  @ForeignKey(() => usuario)
  @Column
  fk_id_user: number;

  @Column
  vlr_total: number;
}
